lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 54.643483483483486 --fixed-mass2 85.99191191191191 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026853135.2451217 \
--gps-end-time 1026860335.2451217 \
--d-distr volume \
--min-distance 5350.096184475373e3 --max-distance 5350.116184475373e3 \
--l-distr fixed --longitude 131.07247924804688 --latitude 52.1794548034668 --i-distr uniform \
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
