lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 38.338938938938945 --fixed-mass2 73.97361361361362 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007788708.2418313 \
--gps-end-time 1007795908.2418313 \
--d-distr volume \
--min-distance 6612.942497462389e3 --max-distance 6612.962497462389e3 \
--l-distr fixed --longitude -116.13627624511719 --latitude -36.45079803466797 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
