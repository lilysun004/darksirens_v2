lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.907707707707708 --fixed-mass2 86.16 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016545969.8939301 \
--gps-end-time 1016553169.8939301 \
--d-distr volume \
--min-distance 703.9280467915183e3 --max-distance 703.9480467915183e3 \
--l-distr fixed --longitude -166.5869140625 --latitude -4.331070423126221 --i-distr uniform \
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
